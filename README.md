# aprendomx/homebrew-tap

Tap de Homebrew de [Splitstream](https://github.com/aprendomx/splitstream): retransmite una señal RTMP de OBS a varias plataformas a la vez, desde tu propio equipo.

```bash
brew install aprendomx/tap/splitstream
brew services start splitstream   # opcional: dejarlo funcionando siempre
```

La fórmula (`Formula/splitstream.rb`) la genera y valida el workflow de release de Splitstream en cada versión: no se edita a mano aquí. La plantilla vive en `deploy/homebrew/` del repo principal.
