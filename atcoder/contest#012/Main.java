import java.util.*;

public class Main {

  public static void main(String args[]) {
  (new Main()).solve();
}

int count[];

void solve() {

  Scanner cin = new Scanner(System.in);

  while( cin.hasNextInt() ) {

    int N = cin.nextInt();
    int T = cin.nextInt();
    int MOD = cin.nextInt();

    long res = 1;
    count = new int[100001];

    for(int i=0; i<N; ++i) {
      int x = Math.abs( cin.nextInt() );
      int y = Math.abs( cin.nextInt() );
      res = res * solve(x, y, T, MOD) % MOD;
    }

    if( res == 1 ) {

      int sum = 0;
      for(int i=100000; i>=0; --i) {
        sum += count[i];
        count[i] = sum;
      }

      boolean vis[] = new boolean[100001];
      for(int i=2; i<=100000; ++i) {
        if( vis[i] ) { continue; }
          long times = 0;
          for(long k=i; k<=100000; k*=i) {
            for(long j=k; j<=100000; j+=k) {
            vis[ (int)(j) ] = true;
            times += count[ (int)(j) ];
          }
          }
          res = res * pow(i, times, MOD) % MOD;
      }

    }

    Sys. out.println(res);
fe
  }

}

long pow(long v, long p, int MOD) {
  if( p == 0 ) { return 1; }
    if( p % 2 == 0 ) { return pow(v * v % MOD, p / 2, MOD); }
      return pow(v * v % MOD, p / 2, MOD) * v % MOD;
}

long solve(int x, int y, int T, int MOD) {

  if( x + y > T ) { return 0; }
    if( (x + y + T) % 2 != 0 ) { return 0; }

      int rest = (T - x - y) / 2;
      // com(T, T/2 - |x - y|/2;
             // com((T + x + y)/2 - 1, x + y);
             ++count[ T ];
             ++count[ x + y + rest + rest ];
             --count[ T - (Math.min(x, y) + rest) ];
             --count[ Math.min(x, y) + rest ];
             --count[ x + y + rest ];
             --count[ rest ];

             return 1;

}

}
