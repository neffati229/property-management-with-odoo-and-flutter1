from odoo import models, fields


class Location(models.Model):
    _name = 'location.management'
    _description = 'Module de gestion de location'
    locataire = fields.Char(string='locataire')
    type = fields.Selection([('type1', 'Type 1'), ('type2', 'Type 2')], string='Type')
    def custom_button(self):
        # Action à exécuter lors du clic sur le bouton personnalisé
        pass
    def custom_button(self):
        # Action à exécuter lors du clic sur le bouton personnalisé
        pass
    def custom_button(self):
        # Action à exécuter lors du clic sur le bouton personnalisé
        pass