#!/usr/bin/python

# Copyright: (c) 2025, maks
# GNU General Public License v3.0+ (see COPYING or https://www.gnu.org/licenses/gpl-3.0.txt)
from __future__ import (absolute_import, division, print_function)
__metaclass__ = type

DOCUMENTATION = r'''
---
module: my_own_module

short_description: Создаёт текстовый файл с заданным содержимым

version_added: "1.0.0"

description:
  - Модуль создаёт или перезаписывает текстовый файл на удалённом хосте.
  - Путь задаётся через параметр `path`, содержимое — через `content`.

options:
    path:
        description: Абсолютный путь к файлу, который нужно создать.
        required: true
        type: str
    content:
        description: Текст, который будет записан в файл.
        required: true
        type: str

author:
    - maks (@maks)
'''

EXAMPLES = r'''
- name: Создать файл конфигурации
  my_own_module:
    path: /etc/myapp/config.txt
    content: |
      debug = true
      log_level = info
'''

RETURN = r'''
path:
    description: Путь к созданному файлу.
    type: str
    returned: always
    sample: "/etc/myapp/config.txt"
original_content:
    description: Содержимое, которое было передано в модуль.
    type: str
    returned: always
    sample: "debug = true\nlog_level = info\n"
changed:
    description: Был ли файл изменён (создан или перезаписан).
    type: bool
    returned: always
'''

from ansible.module_utils.basic import AnsibleModule
import os

def run_module():
    module_args = dict(
        path=dict(type='str', required=True),
        content=dict(type='str', required=True)
    )

    result = dict(
        changed=False,
        path='',
        original_content=''
    )

    module = AnsibleModule(
        argument_spec=module_args,
        supports_check_mode=True
    )

    path = module.params['path']
    content = module.params['content']
    result['original_content'] = content
    result['path'] = path

    # Режим проверки — не вносим изменения
    if module.check_mode:
        # Проверим, существует ли файл и совпадает ли содержимое
        if os.path.exists(path):
            with open(path, 'r') as f:
                current = f.read()
            if current != content:
                result['changed'] = True
        else:
            result['changed'] = True
        module.exit_json(**result)

    # Реальный режим
    try:
        # Проверяем текущее содержимое, если файл существует
        if os.path.exists(path):
            with open(path, 'r') as f:
                current_content = f.read()
            if current_content == content:
                # Файл уже содержит нужные данные — ничего не меняем
                module.exit_json(**result)
        # Если файл не существует или содержимое отличается — записываем
        with open(path, 'w') as f:
            f.write(content)
        result['changed'] = True
    except Exception as e:
        module.fail_json(msg=f"Не удалось записать файл по пути {path}: {str(e)}", **result)

    module.exit_json(**result)


def main():
    run_module()


if __name__ == '__main__':
    main()
