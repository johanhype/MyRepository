namespace: flowAuthoring
flow:
  name: Get_Local_IP_Address
  workflow:
    - run_command:
        do:
          io.cloudslang.base.cmd.run_command:
            - command: ipconfig
        publish:
          - return_result: "${cs_regex(return_result,\"Addres.* (\\d{1,3}\\.\\d{1,3}\\.\\d{1,3}\\.\\d{1,3})\")}"
        navigate:
          - SUCCESS: SUCCESS
          - FAILURE: on_failure
  results:
    - FAILURE
    - SUCCESS
extensions:
  graph:
    steps:
      run_command:
        x: 320
        'y': 200
        navigate:
          78d39e08-3c1f-afe5-4db5-2854bda077df:
            targetId: 4f5e1270-d9ae-50e0-32c3-e11cc22fcd33
            port: SUCCESS
    results:
      SUCCESS:
        4f5e1270-d9ae-50e0-32c3-e11cc22fcd33:
          x: 480
          'y': 200
