namespace: AOS
flow:
  name: send_query
  inputs:
    - category_f
    - product_f
    - email_f
    - subject_f
  workflow:
    - send_query_act:
        do:
          AOS.send_query_act:
            - category: '${category_f}'
            - product: '${product_f}'
            - email: '${email_f}'
            - subject: '${subject_f}'
        publish:
          - send_status
        navigate:
          - SUCCESS: string_equals
          - WARNING: string_equals
          - FAILURE: on_failure
    - string_equals:
        do:
          io.cloudslang.base.strings.string_equals:
            - first_string: '${send_status}'
            - second_string: Thank you for contacting Advantage support.
        navigate:
          - SUCCESS: SUCCESS
          - FAILURE: on_failure
  outputs:
    - send_status
  results:
    - FAILURE
    - SUCCESS
extensions:
  graph:
    steps:
      send_query_act:
        x: 160
        'y': 160
      string_equals:
        x: 400
        'y': 160
        navigate:
          a51612e5-87b0-2ff4-98bd-40f1f755f49c:
            targetId: 74033bb4-1507-4b3a-f757-a7eceaf5d9fd
            port: SUCCESS
    results:
      SUCCESS:
        74033bb4-1507-4b3a-f757-a7eceaf5d9fd:
          x: 680
          'y': 160
