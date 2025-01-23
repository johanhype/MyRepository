namespace: web_action
flow:
  name: register_account_flow
  workflow:
    - register_account:
        do:
          web_action.register_account:
            - url: 'http://oo-vm02.itomlabs.com:8082/'
        publish:
          - return_result
          - error_message
        navigate:
          - SUCCESS: SUCCESS
          - WARNING: SUCCESS
          - FAILURE: on_failure
  outputs:
    - return_result
    - error_message
  results:
    - SUCCESS
    - FAILURE
extensions:
  graph:
    steps:
      register_account:
        x: 100
        'y': 150
        navigate:
          168e9fdf-269b-200d-4fee-875df5b34235:
            targetId: 7d4702d0-dafd-c69f-a943-1678625429a4
            port: SUCCESS
          1d6e725c-2613-d0c8-357e-daa89fec2ec5:
            targetId: 7d4702d0-dafd-c69f-a943-1678625429a4
            port: WARNING
    results:
      SUCCESS:
        7d4702d0-dafd-c69f-a943-1678625429a4:
          x: 400
          'y': 150
