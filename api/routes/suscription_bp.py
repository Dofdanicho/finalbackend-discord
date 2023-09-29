from flask import Blueprint
from ..controllers.suscriptionController import SuscriptionController


suscription_bp = Blueprint('suscription_bp', __name__)

@suscription_bp.route('/all', methods=['GET'])
def listar_suscripciones():
    return SuscriptionController.get_suscriptions()