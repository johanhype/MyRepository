namespace: RemoteExecution
flow:
  name: PowerShell
  workflow:
    - powershell_script:
        do:
          io.cloudslang.base.powershell.powershell_script:
            - host: avm-2012
            - port: '5985'
            - protocol: http
            - username: administrator
            - password:
                value: password
                sensitive: true
            - script: get-host
            - trust_all_roots: 'true'
        publish:
          - output_0: '${return_result}'
        navigate:
          - SUCCESS: Display_Message
          - FAILURE: on_failure
    - Display_Message:
        do_external:
          434e6fa2-26bc-4e84-9e1f-0aa6946cf920:
            - message: '${output_0}'
        navigate:
          - success: SUCCESS
  results:
    - SUCCESS
    - FAILURE
extensions:
  graph:
    steps:
      powershell_script:
        x: 240
        'y': 160
      Display_Message:
        x: 440
        'y': 160
        navigate:
          7439dd86-5778-95a3-035d-c012559e6681:
            targetId: 2d681a42-bfe4-2430-c252-4c92a0b85f51
            port: success
    results:
      SUCCESS:
        2d681a42-bfe4-2430-c252-4c92a0b85f51:
          x: 720
          'y': 160
