command: """
./right.sh
"""

refreshFrequency: 10000

style: """
  top: 1px
  right: 1px
  color: #0e1610
  .output
    font-family: JetBrainsMonoMedium Nerd Font Mono
    font-size: 13px
    font-weight: 100
"""

render: (output) -> """
  <div class="output">#{output}</div>
"""
