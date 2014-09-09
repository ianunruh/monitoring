#!/usr/bin/env python
from argparse import ArgumentParser
import random
import time

from raven import Client

def main():
    parser = ArgumentParser()
    parser.add_argument('dsn')

    args = parser.parse_args()

    client = Client(args.dsn)

    exceptions = (RuntimeError, NotImplementedError, ZeroDivisionError)

    while True:
        exception = random.choice(exceptions)
        print exception

        try:
            raise exception
        except:
            client.captureException()

        time.sleep(random.random())

if __name__ == '__main__':
    main()
