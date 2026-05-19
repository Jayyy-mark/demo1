import logging
from logging.config import fileConfig

from flask import current_app
from sqlalchemy import engine_from_config, pool
from alembic import context

config = context.config
fileConfig(config.config_file_name)
logger = logging.getLogger("alembic.env")

target_db = None


# =========================
# SAFE ENGINE RESOLUTION
# =========================
def get_engine():
    """
    Prefer runtime Flask DB engine, fallback to config URL engine.
    """
    try:
        db = current_app.extensions["migrate"].db

        # Flask-SQLAlchemy 3+
        if hasattr(db, "engine"):
            return db.engine

        # older versions
        return db.get_engine()

    except Exception:
        # fallback: build engine from alembic.ini
        url = config.get_main_option("sqlalchemy.url")
        from sqlalchemy import create_engine
        return create_engine(url)


def get_engine_url():
    try:
        return str(get_engine().url).replace("%", "%%")
    except Exception:
        return config.get_main_option("sqlalchemy.url")


# IMPORTANT: force correct DB URL into alembic config
config.set_main_option("sqlalchemy.url", get_engine_url())


# =========================
# METADATA
# =========================
def get_metadata():
    global target_db
    if target_db is None:
        target_db = current_app.extensions["migrate"].db

    if hasattr(target_db, "metadatas"):
        return target_db.metadatas[None]
    return target_db.metadata


# =========================
# OFFLINE MODE
# =========================
def run_migrations_offline():
    url = config.get_main_option("sqlalchemy.url")

    context.configure(
        url=url,
        target_metadata=get_metadata(),
        literal_binds=True,
        dialect_opts={"paramstyle": "named"},
    )

    with context.begin_transaction():
        context.run_migrations()


# =========================
# ONLINE MODE
# =========================
def run_migrations_online():

    def process_revision_directives(context, revision, directives):
        if getattr(config.cmd_opts, "autogenerate", False):
            script = directives[0]
            if script.upgrade_ops.is_empty():
                directives[:] = []
                logger.info("No schema changes detected.")

    connectable = get_engine()

    with connectable.connect() as connection:

        context.configure(
            connection=connection,
            target_metadata=get_metadata(),

            # ✅ FORCE clean values ONLY ONCE
            compare_type=True,
            render_as_batch=True,

            # ❌ DO NOT spread Flask-Migrate configure_args
        )

        with context.begin_transaction():
            context.run_migrations()

# =========================
# RUN
# =========================
if context.is_offline_mode():
    run_migrations_offline()
else:
    run_migrations_online()