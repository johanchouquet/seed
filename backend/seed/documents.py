from mongoengine import *

class Message(Document):
    text = StringField()

