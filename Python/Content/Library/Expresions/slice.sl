namespace: Expresions
flow:
  name: slice
  workflow:
    - json_path_query:
        do:
          io.cloudslang.base.json.json_path_query:
            - json_object: |-
                ${'''
                {
                    "names" : ["Adam", "Thom", "David", "Mary"]
                }
                '''}
            - json_path: $.names
        publish:
          - id: '${str(eval(return_result)[::-1])}'
        navigate:
          - SUCCESS: SUCCESS
          - FAILURE: on_failure
  results:
    - FAILURE
    - SUCCESS
extensions:
  graph:
    steps:
      json_path_query:
        x: 400
        'y': 160
        navigate:
          f0ebe598-a098-2f46-b935-fe743432ca7a:
            targetId: 1741cd53-692d-fe17-c9c6-3f8d0549beb1
            port: SUCCESS
    results:
      SUCCESS:
        1741cd53-692d-fe17-c9c6-3f8d0549beb1:
          x: 560
          'y': 160
