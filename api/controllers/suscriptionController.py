from flask import request, jsonify, session
from api.database import *
from ..models.suscription_model import Suscription 

class SuscriptionController:
    @classmethod
    def get_suscriptions(self):
        """Retrieves suscription from the database, through a user id."""
        sql = "SELECT * FROM discord_app.suscription;"
        resultado = DatabaseConnection.fetch_all(sql)
        suscriptions = []
        if resultado is not None:
            for suscription in resultado:
                suscriptions.append({
                    'user_name': suscription[0],
                    'server_name': suscription[1],
                    
                })
        return jsonify(suscriptions), 200