command: """
./scripts/window.sh 1
"""

refreshFrequency: 500

style: """
  top: 1px
  left: 1px
  color: #0e1610

  .output
    font-family: JetBrainsMonoMedium Nerd Font Mono
    font-size: 13px
    font-weight: 100
"""

render: (output) -> """
  <div class="output">#{output}</div>
"""
