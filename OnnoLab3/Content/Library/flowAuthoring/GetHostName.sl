namespace: flowAuthoring
flow:
  name: GetHostName
  inputs:
    - hostname
  workflow:
    - run_command:
        worker_group: worker_group1
        do:
          io.cloudslang.base.cmd.run_command:
            - command: Hostname
        publish:
          - server_name: '${return_result}'
        navigate:
          - SUCCESS: Display_Message
          - FAILURE: on_failure
    - Display_Message:
        do_external:
          434e6fa2-26bc-4e84-9e1f-0aa6946cf920:
            - message: "${'The hostname is:' + server_name}"
        navigate:
          - success: SUCCESS
  results:
    - SUCCESS
    - FAILURE
extensions:
  graph:
    steps:
      run_command:
        x: 360
        'y': 280
      Display_Message:
        x: 600
        'y': 280
        navigate:
          f9d45891-720b-4238-a9f4-e4895d1830f8:
            targetId: 1566737a-5017-48e2-79d3-ceceadd229af
            port: success
    results:
      SUCCESS:
        1566737a-5017-48e2-79d3-ceceadd229af:
          x: 800
          'y': 320
