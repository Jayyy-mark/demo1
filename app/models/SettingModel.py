from app.core.database import db

class Setting(db.Model):

    __tablename__ = "settings"

    id = db.Column(db.Integer, primary_key=True, autoincrement=True)

    app_installed = db.Column(db.Boolean, nullable=False, default=False)


    def isInstalled(self):
        return self.app_installed