from .activity import ActivitySchema
from app.models.MediaModel import Media
from app.core.database import ma

class MediaSchema(ma.SQLAlchemyAutoSchema):
    class Meta:
        model=Media
        load_instance=True
        include_fk=True
    
    activity = ma.Nested(ActivitySchema)
