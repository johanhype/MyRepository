namespace: MYCSflows
flow:
  name: displayHostname
  workflow:
    - flowsample:
        do:
          Processflow.flowsample: []
        navigate:
          - SUCCESS: SUCCESS
          - FAILURE: on_failure
  results:
    - FAILURE
    - SUCCESS
extensions:
  graph:
    steps:
      flowsample:
        x: 400
        'y': 200
        navigate:
          7dccb4a9-3fed-2ae6-26d8-316777890fa4:
            targetId: b036ddb5-a6df-308f-7046-ef98746441a6
            port: SUCCESS
    results:
      SUCCESS:
        b036ddb5-a6df-308f-7046-ef98746441a6:
          x: 600
          'y': 200
