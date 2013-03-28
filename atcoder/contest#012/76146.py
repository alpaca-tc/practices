import sys
N, va, vb, L = [int(x) for x in sys.stdin.readline().rstrip().split()]
for i in xrange(N):
    time = L / float(va)
    L = vb * time
    print L
