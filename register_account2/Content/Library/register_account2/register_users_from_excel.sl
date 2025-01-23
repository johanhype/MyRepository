namespace: register_account2
flow:
  name: register_users_from_excel
  inputs:
    - excel_path: "C:\\Users\\Admin\\Desktop\\users.xls"
    - sheet: Sheet1
    - login_header: Username
    - password_header: Password
    - name_header: Full Name
    - email_header: Email
  workflow:
    - Get_Cell:
        do_external:
          5060d8cc-d03c-43fe-946f-7babaaec589f:
            - excelFileName: '${excel_path}'
            - worksheetName: '${sheet}'
            - hasHeader: 'yes'
            - rowIndex: '0:1000'
            - columnIndex: '0:100'
            - rowDelimiter: '|'
            - columnDelimiter: ','
            - password_header: '${password_header}'
            - email_header: '${email_header}'
            - name_header: '${name_header}'
            - login_header: '${login_header}'
        publish:
          - data: '${returnResult}'
          - header
          - login_index: "${str(header.split(',').index(login_header))}"
          - password_index: "${str(header.split(',').index(password_header))}"
          - email_index: "${str(header.split(',').index(email_header))}"
          - name_index: "${str(header.split(',').index(name_header))}"
        navigate:
          - failure: FAILURE
          - success: register_account2_flow
    - register_account2_flow:
        loop:
          for: 'row in data.split("|")'
          do:
            register_account2.register_account2_flow:
              - username: '${row.split(",")[int(login_index)]}'
              - password: '${row.split(",")[int(password_index)]}'
              - first_name: '${row.split(",")[int(name_index)].split()[0]}'
              - last_name: '${row.split(",")[int(name_index)].split()[1]}'
              - email: '${row.split(",")[int(email_index)]}'
          break:
            - FAILURE
        navigate:
          - SUCCESS: SUCCESS
          - FAILURE: on_failure
  results:
    - SUCCESS
    - FAILURE
extensions:
  graph:
    steps:
      Get_Cell:
        x: 80
        'y': 320
        navigate:
          c820697d-df17-d05a-a330-9cecb16a3de7:
            targetId: 80d53621-de1f-c3a0-9d42-871957c048c2
            port: failure
      register_account2_flow:
        x: 280
        'y': 240
        navigate:
          9fcbeed1-9112-773a-7519-0564451ad784:
            targetId: c48c5aa3-62d8-038d-49d5-be5c96a8f6b6
            port: SUCCESS
    results:
      SUCCESS:
        c48c5aa3-62d8-038d-49d5-be5c96a8f6b6:
          x: 440
          'y': 160
      FAILURE:
        80d53621-de1f-c3a0-9d42-871957c048c2:
          x: 280
          'y': 400
