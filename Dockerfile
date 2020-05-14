FROM node:10

SHELL ["/bin/bash", "-c"]
RUN groupadd -r prisma && useradd -r -m -s /bin/false -g prisma prisma

COPY nexus/ /nexus/
WORKDIR /nexus/
RUN chmod +x entry-point.sh

ENV POSTGRES_URL="postgresql://overwrite"

RUN npm i

ENTRYPOINT ["/nexus/entry-point.sh"]
CMD ["npm", "run", "dev"]