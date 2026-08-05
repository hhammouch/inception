FROM debian:bookworm

RUN apt-get update && apt-get install -y python3 python3-pip python3-dev gcc && rm -rf /var/lib/apt/lists/*

# Combine both the web and containers bundles
RUN pip3 install --break-system-packages 'glances[web,containers]'

EXPOSE 61208

CMD ["glances", "-w"]