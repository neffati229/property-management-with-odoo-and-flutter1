from odoo import models, fields, _


class TestModelWizard(models.TransientModel):
    _name = 'wizard.model.wizard'
    _description = 'Wizard Model Wizard'

    test_field = fields.Char(string='Wizard Field')
    locataire = fields.Char(string='locataire', required= True)
    type = fields.Selection([('person', 'Individu'), ('company', 'Société')], string='Type')

    def ustom_button(self):
        # Action à exécuter lors du clic sur le bouton personnalisé
        pass

    def custom_button(self):
        self.env['res.partner'].create({
            'name': self.locataire,
            'company_type': self.type,
        })
        pass

    def create_custom(self):
        self.env['res.partner'].create({
            'name': self.locataire,
            'company_type': self.type,
        })
        return {
            'type': 'ir.actions.act_window',
            'target': 'new',
            'name': _('Crée'),
            'view_mode': 'form',
            'res_model': 'wizard.model.wizard',
        }
