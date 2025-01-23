namespace: Expresions
flow:
  name: sha1_flow
  workflow:
    - sha1:
        do:
          Expresions.sha1:
            - text: tests
        navigate:
          - SUCCESS: SUCCESS
  results:
    - SUCCESS
extensions:
  graph:
    steps:
      sha1:
        x: 600
        'y': 240
        navigate:
          b70dc5af-9aa4-4501-0a63-c1a7670f21fc:
            targetId: 43583c9a-d2d6-8405-5f69-39f6b9314269
            port: SUCCESS
    results:
      SUCCESS:
        43583c9a-d2d6-8405-5f69-39f6b9314269:
          x: 800
          'y': 240
