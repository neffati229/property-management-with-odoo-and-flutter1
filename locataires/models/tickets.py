# -*- coding: utf-8 -*-
import base64
from odoo import models, fields




class TicketsTemplate(models.Model):
    _inherit = 'helpdesk.ticket'

    # state = fields.Selection(selection=[
    #     ('traiter', 'A traiter'),
    #     ('locataire', 'Locataire'),
    #     ('propriétaire', 'Propriétaire'),
    #     ('fournisseur', 'Fournisseur'),
    #     ('intervention', 'Intervention'),
    #     ('fermer', 'Fermé'),
    #     ('rejeté', 'Rejeté'),
    #
    # ], string='Status', readonly=True, default='traiter')
    # image = fields.Binary(string="Image", default=_default_image)
    images = fields.Binary(string='Images')
    bien = fields.Many2one('bien.management', string='Bien')
    propriétaire = fields.Many2one('res.partner', string='Propriétaire')
    bail = fields.Many2one('bail.contract', string='Bail')
    contact_de_bail = fields.Many2one('res.partner', string='Contact de bail')
        # :mte3 mola dar
    # def create_ticket(self, name, description):
    #     vals = {
    #         'name': name,
    #         'description': description,
    #     }
    #     self.create(vals)
