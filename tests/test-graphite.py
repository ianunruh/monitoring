#!/usr/bin/env python
from argparse import ArgumentParser
import math
import socket
import sys
from time import sleep, time

def loop(sock, interval, metric_name, max_points, verbose):
    n = 0

    while True:
        for d in range(0, 360):
            x = math.sin(math.radians(d))
            msg = '{} {} {}\n'.format(metric_name, x, int(time()))

            if verbose:
                sys.stdout.write(msg)

            sock.sendall(msg)

            n += 1

            if max_points > 0 and n == max_points:
                return

            sleep(interval)

def main():
    parser = ArgumentParser()
    parser.add_argument('--host', default='localhost')
    parser.add_argument('-p', '--port', type=int, default=2013)
    parser.add_argument('-m', '--max-points', type=int, default=0)
    parser.add_argument('-n', '--name', default='foo.bar.baz')
    parser.add_argument('-i', '--interval', type=float, default=0.1)
    parser.add_argument('-v', '--verbose', action='store_true')

    args = parser.parse_args()

    if args.verbose:
        print "Connecting to {}:{}".format(args.host, args.port)

    sock = socket.socket()
    sock.connect((args.host, args.port))

    try:
        loop(sock, args.interval, args.name, args.max_points, args.verbose)
    except KeyboardInterrupt:
        pass
    finally:
        sock.close()

if __name__ == '__main__':
    main()
