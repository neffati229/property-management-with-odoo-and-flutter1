from odoo import models, fields
class BienManagement(models.Model):
    _name = 'bien.management'
    _description = 'Module de gestion de bien'

    name = fields.Char(string="Nom", required=True)
    Dis_location = fields.Boolean(string="Disponible pour la location")
    bien_parent = fields.Many2one('bien.management', string="Bien Parent")
    code_du_bien = fields.Char(string="Code du bien")
    type = fields.Selection([('batiment', 'batiment'), ('ville', 'ville'), ('maison', 'maison')], string="Type")
    gestionaire = fields.Many2one('res.partner', string="Gestionnaire")

    proprietaire = fields.Many2one('res.partner', string="proprietaire")
    street = fields.Char(string='Rue')
    street2 = fields.Char(string='Rue 2')
    city = fields.Char(string='Ville')
    state_id = fields.Many2one('res.country.state', string='État')
    zip = fields.Char(string='Code postal')
    country_id = fields.Many2one('res.country', string='Pays')
    photo = fields.Binary(string="Photo du bien")
