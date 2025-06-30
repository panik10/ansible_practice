# ansible_practice

The original lessons are here: https://www.youtube.com/watch?v=FFaMqxpphjo&list=PLT98CRl2KxKEUHie1m24-wkyHpEsa4Y70&index=1

| To create a test machine run this command in the current folder:
```
docker build -t ubuntu-ssh:1.0 .
```

Then create containers:
```
docker run -p3001:22 --name ubuntu-1 ubuntu-ssh:1.0
```

*if you need more instances - alter the port binding, e.g. -p3002:22, and a name