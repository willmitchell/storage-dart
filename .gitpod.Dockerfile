FROM gitpod/workspace-full

USER gitpod

# RUN apt update && apt install snapd -y
# RUN snap install core
# RUN snap install flutter --classic

RUN brew tap dart-lang/dart && brew install dart
