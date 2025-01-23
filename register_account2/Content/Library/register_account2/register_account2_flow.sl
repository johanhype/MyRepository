namespace: register_account2
flow:
  name: register_account2_flow
  inputs:
    - url: 'http://00-vm02.itomlabs.com:8082/'
    - username: helenk
    - password: Helenk01
    - first_name: Helen
    - last_name: Keller
    - email: hk@merant.com
  workflow:
    - register_account2:
        do:
          register_account2.register_account2:
            - url: '${url}'
            - username: '${username}'
            - password: '${password}'
            - first_name: '${first_name}'
            - last_name: '${last_name}'
            - email: '${email}'
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
      register_account2:
        x: 100
        'y': 150
        navigate:
          78d44dc8-ee38-3725-690f-6118d8999293:
            targetId: d3078fa2-5357-5db7-f0a2-cfd7f000300c
            port: SUCCESS
          f3a12c20-f891-2a2d-4772-c0f707510e9a:
            targetId: d3078fa2-5357-5db7-f0a2-cfd7f000300c
            port: WARNING
    results:
      SUCCESS:
        d3078fa2-5357-5db7-f0a2-cfd7f000300c:
          x: 400
          'y': 150
