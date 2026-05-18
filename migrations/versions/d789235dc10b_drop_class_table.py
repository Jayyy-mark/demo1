"""drop class table

Revision ID: d789235dc10b
Revises: 78c03b14b59c
Create Date: 2025-10-16 16:21:57.989163

"""
from alembic import op
import sqlalchemy as sa
from sqlalchemy.dialects import mysql

# revision identifiers, used by Alembic.
revision = 'd789235dc10b'
down_revision = '78c03b14b59c'
branch_labels = None
depends_on = None


def upgrade():
    # 1️⃣ Drop foreign key constraints and class_id columns first
    with op.batch_alter_table('courses', schema=None) as batch_op:
        batch_op.drop_constraint(batch_op.f('courses_ibfk_1'), type_='foreignkey')
        batch_op.drop_column('class_id')
        batch_op.add_column(sa.Column('semester_id', sa.Integer(), nullable=False))
        batch_op.create_foreign_key(None, 'semesters', ['semester_id'], ['id'], ondelete='CASCADE')

    with op.batch_alter_table('students', schema=None) as batch_op:
        batch_op.drop_constraint(batch_op.f('students_ibfk_1'), type_='foreignkey')
        batch_op.drop_column('class_id')
        batch_op.add_column(sa.Column('semester_id', sa.Integer(), nullable=True))
        batch_op.create_foreign_key(None, 'semesters', ['semester_id'], ['id'], ondelete='CASCADE')

    with op.batch_alter_table('timetable', schema=None) as batch_op:
        batch_op.drop_constraint(batch_op.f('timetable_ibfk_1'), type_='foreignkey')
        batch_op.drop_column('class_id')
        batch_op.add_column(sa.Column('semester_id', sa.Integer(), nullable=False))
        batch_op.create_foreign_key(None, 'semesters', ['semester_id'], ['id'], ondelete='CASCADE')

    # Subjects table didn’t reference classes directly, just add new FKs
    with op.batch_alter_table('subjects', schema=None) as batch_op:
        batch_op.add_column(sa.Column('semester_id', sa.Integer(), nullable=False))
        batch_op.add_column(sa.Column('course_id', sa.Integer(), nullable=False))
        batch_op.create_foreign_key(None, 'courses', ['course_id'], ['id'], ondelete='CASCADE')
        batch_op.create_foreign_key(None, 'semesters', ['semester_id'], ['id'], ondelete='CASCADE')

    # 2️⃣ Now drop the classes table safely
    op.drop_table('classes')


def downgrade():
    # Recreate classes table first
    op.create_table('classes',
        sa.Column('id', mysql.INTEGER(display_width=11), autoincrement=True, nullable=False),
        sa.Column('class_id', mysql.VARCHAR(length=100), nullable=False),
        sa.Column('class_name', mysql.VARCHAR(length=100), nullable=False),
        sa.Column('major_id', mysql.INTEGER(display_width=11), autoincrement=False, nullable=False),
        sa.ForeignKeyConstraint(['major_id'], ['majors.id'], name=op.f('classes_ibfk_1'), ondelete='CASCADE'),
        sa.PrimaryKeyConstraint('id'),
        mysql_collate='utf8mb4_general_ci',
        mysql_default_charset='utf8mb4',
        mysql_engine='InnoDB'
    )

    # Add class_id columns and FKs back
    with op.batch_alter_table('courses', schema=None) as batch_op:
        batch_op.add_column(sa.Column('class_id', mysql.INTEGER(display_width=11), nullable=False))
        batch_op.drop_constraint(None, type_='foreignkey')
        batch_op.create_foreign_key(batch_op.f('courses_ibfk_1'), 'classes', ['class_id'], ['id'], ondelete='CASCADE')
        batch_op.drop_column('semester_id')

    with op.batch_alter_table('students', schema=None) as batch_op:
        batch_op.add_column(sa.Column('class_id', mysql.INTEGER(display_width=11), nullable=True))
        batch_op.drop_constraint(None, type_='foreignkey')
        batch_op.create_foreign_key(batch_op.f('students_ibfk_1'), 'classes', ['class_id'], ['id'], ondelete='CASCADE')
        batch_op.drop_column('semester_id')

    with op.batch_alter_table('timetable', schema=None) as batch_op:
        batch_op.add_column(sa.Column('class_id', mysql.INTEGER(display_width=11), nullable=False))
        batch_op.drop_constraint(None, type_='foreignkey')
        batch_op.create_foreign_key(batch_op.f('timetable_ibfk_1'), 'classes', ['class_id'], ['id'], ondelete='CASCADE')
        batch_op.drop_column('semester_id')

    with op.batch_alter_table('subjects', schema=None) as batch_op:
        batch_op.drop_constraint(None, type_='foreignkey')
        batch_op.drop_constraint(None, type_='foreignkey')
        batch_op.drop_column('course_id')
        batch_op.drop_column('semester_id')


    op.create_table('classes',
    sa.Column('id', mysql.INTEGER(display_width=11), autoincrement=True, nullable=False),
    sa.Column('class_id', mysql.VARCHAR(length=100), nullable=False),
    sa.Column('class_name', mysql.VARCHAR(length=100), nullable=False),
    sa.Column('major_id', mysql.INTEGER(display_width=11), autoincrement=False, nullable=False),
    sa.ForeignKeyConstraint(['major_id'], ['majors.id'], name=op.f('classes_ibfk_1'), ondelete='CASCADE'),
    sa.PrimaryKeyConstraint('id'),
    mysql_collate='utf8mb4_general_ci',
    mysql_default_charset='utf8mb4',
    mysql_engine='InnoDB'
    )
    # ### end Alembic commands ###
