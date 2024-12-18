FROM golang:1.19-alpine as builder

WORKDIR /usr/src/app

COPY . .

RUN CGO_ENABLED=0 GOOS=linux go build -a -installsuffix cgo -o go-api ./main.go

FROM scratch

WORKDIR /usr/src/app

COPY --from=builder /usr/src/app/go-api /usr/src/app/main

CMD [ "./main" ]