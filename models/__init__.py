#!/usr/bin/python3
<<<<<<< HEAD
"""This module instantiates an instance of the Storage will be used"""
=======
"""This module instantiates an object of class FileStorage"""
#from models.engine.file_storage import FileStorage
>>>>>>> b86e50d7eaeeeea67cdddb5b4389503932330be7

from os import getenv

storage_type = getenv('HBNB_TYPE_STORAGE')

if storage_type == 'db':
    from models.engine.db_storage import DBStorage
    storage = DBStorage()
else:
    from models.engine.file_storage import FileStorage
    storage = FileStorage()

storage.reload()
