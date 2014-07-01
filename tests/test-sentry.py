from raven import Client
import random
import time

client = Client('YOUR_DSN_GOES_HERE')

exceptions = (RuntimeError, NotImplementedError, ZeroDivisionError)

while True:
    exception = random.choice(exceptions)
    print exception

    try:
        raise exception
    except:
        client.captureException()

    time.sleep(random.random())
