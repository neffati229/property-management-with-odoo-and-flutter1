# -*- coding: utf-8 -*-
from dateutil.relativedelta import relativedelta
from odoo import models, fields,api

class BailContract(models.Model):
    _name = 'bail.contract'

    bien = fields.Many2one('bien.management', string='Bien', required=True, domain="[('Dis_location', '=', False)]")
    gestionaire = fields.Many2one('res.partner', string="Gestionaire")
    # type_dubail = fields.Many2one('res.partner', string="type_du_bail")

    type_dubaill = fields.Selection([(' déterminée', 'Contrat de location à durée déterminée'),
                    ('indéterminée', 'Contrat de location à durée indéterminée'),
                    ('saisonnière', 'Contrat de location saisonnière '),('achat ','Contrat de location avec option d achat '),
                    ('meublée','Contrat de location meublée') ], string="type_du_baill")

    duree = fields.Float(string='Durée', compute='_compute_duree', store=True)
    date_de_debut = fields.Date(string="Date de début")
    date_de_fin = fields.Date(string="Date de fin")
    date_de_signature = fields.Date(string="Date de signature")
    prix = fields.Float(string='prix')
    # product_ids = fields.Many2many('product.template', string="Article")
    state = fields.Selection(selection=[
        ('draft', 'brouillon'),
        ('ouvrir', 'valider'),
        ('fermer', 'Fermé'),

    ], string='Status', readonly=True, default='draft')

    def button_in_progress(self):
        self.write({
            'state': "ouvrir"
        })

    def custom_button(self):
            self.write({
                'state': "draft"
            })

    def button_progress(self):
                self.write({
                    'state': "fermer"
                })
# write :todkhol aale base de donner
# self model ili ena fih

    @api.depends('date_de_debut', 'date_de_fin')
    def _compute_duree(self):
            for record in self:
                if record.date_de_debut and record.date_de_fin:
                    delta = relativedelta(record.date_de_fin, record.date_de_debut)
                    record.duree = delta.years * 12 + delta.months
                else:
                    record.duree = 0.0


# veux liste bech ibarcurer bel weh bel wehd :self in
# veux forme bech ykhdem aale wahda bark

