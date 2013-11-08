#include <stdio.h>
#include <vector>
#include <math.h>

long double hypot(const long double &a, const long double &b) {
    return sqrt(a * a + b * b);
}

int main() {
    int n;
    int start, goal;
    scanf("%d", &n);
    scanf("%d %d", &start, &goal);
    int left, right;
    std::vector<int> l(n+1), r(n+1);
    for (int i = 0; i <= n; ++i) {
        scanf("%d %d", &left, &right);
        l[i] = left;
        r[i] = right;
    }
    l[0] = start; r[0] = start;
    l[n] = goal; r[n] = goal;
    std::vector<int> ql(n+1);
    int lmin = 0, lmax = 0;
    std::vector<int> qr(n+1);
    int rmin = 0, rmax = 0;

    long double distance = 0.0;
    int x = start;
    int y = 0;
    for (int i = 1; i <= n; ++i) {
        for (; lmax > lmin; ) {
            int py = ql[--lmax];
            int px = l[py];
            int ppy = y;
            int ppx = x;
            if (lmax > lmin) {
                ppy = ql[lmax-1];
                ppx = l[ppy];
            }
            if ((long double)(px - ppx) / (long double)(py - ppy) > (long double)(l[i] - px) / (long double)(i - py)) {
                lmax++;
                break;
            }
        }
        for (; rmax > rmin; ) {
            int py = qr[--rmax];
            int px = r[py];
            int ppy = y;
            int ppx = x;
            if (rmax > rmin) {
                ppy = qr[rmax - 1];
                ppx = r[ppy];
            }
            if ((long double)(ppx - px) / (long double)(ppy - py) < (long double)(r[i] - px) / (long double)(i - py)) {
                rmax++;
                break;
            }
        }
        ql[lmax++] = qr[rmax++] = i;
        while ((long double)(l[ql[lmin]] - x) / (long double)(ql[lmin] - y) > (long double)(r[qr[rmin]] - x) / (long double)(qr[rmin] - y)) {
            if (ql[lmin] < qr[rmin]) {
                distance += hypot((long double)(y - ql[lmin]), (long double)(x - l[ql[lmin]]));
                y = ql[lmin];
                x = l[y];
                lmin++;
            } else {
                distance += hypot((long double)(y - qr[rmin]), (long double)(x - r[qr[rmin]]));
                y = qr[rmin];
                x = r[y];
                rmin++;
            }
        }
    }
    while (lmin < lmax) {
        distance += hypot((long double)(y - ql[lmin]), (long double)(x - l[ql[lmin]]));
        y = ql[lmin];
        x = l[y];
        lmin++;
    }
    printf("%0.15Lf\n", distance);
}
