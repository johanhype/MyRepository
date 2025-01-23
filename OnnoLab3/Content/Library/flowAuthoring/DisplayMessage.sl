namespace: flowAuthoring
flow:
  name: DisplayMessage
  workflow:
    - Display_Message:
        do_external:
          434e6fa2-26bc-4e84-9e1f-0aa6946cf920:
            - message:
                prompt:
                  type: text
        navigate:
          - success: SUCCESS
  results:
    - SUCCESS
extensions:
  graph:
    steps:
      Display_Message:
        x: 320
        'y': 240
        navigate:
          066e3ac7-df91-1227-7d51-549cd916ed36:
            targetId: 2e2913b9-67fd-b558-3e72-6da0f260944f
            port: success
    results:
      SUCCESS:
        2e2913b9-67fd-b558-3e72-6da0f260944f:
          x: 520
          'y': 240
