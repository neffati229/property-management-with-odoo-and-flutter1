# -*- coding: utf-8 -*-
# Part of Odoo. See LICENSE file for full copyright and licensing details.
{
    'name' : 'locataires',
    'version' : '1.1',
    'summary': 'locataires',
    'sequence': 10,
    'description': """
    """,
    'category': '',
    'website': 'https://www.odoo.com/page/billing',
    'depends': ['helpdesk', 'web_cohort', 'contacts'],
    'data': [
        'security/ir.model.access.csv',
        'views/bien.xml',
        'wizard/wizard.xml',
        # 'views/location.xml',
        'views/tickets.xml',
        'views/bail.xml',
    ],
    'installable': True,
    'application': True,
    'auto_install': False,
    'license': 'LGPL-3',
}
