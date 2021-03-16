# Convergence test for online mean algorithm
# very part of q-learning

from random import random, shuffle
import matplotlib.pyplot as plt

V = 0
n = 0
s = 0
A = 200

values = [int(100*random()) for i in range(10000)]

QM = []
VM = []
D = []
for v in values:
  alpha_n = 1/(A**0.9)
  # sum (alpha_n)    = 1/(A)**0.9      + 1/(A+1)**0.9    + 1/(A+2)**0.9 +  ..... = oo
  # sum (alpha_n**2) =    1/(A)**0.81  + 1/(A+1)**0.81   + 1/(A+2)**0.81 + .... = oo

  # Try different values of power. Smaller than 1, and greater than > 1.
  # Algorithm converges when sum(alpha_n,1,oo) > oo and sum(alpha_n**2,1,oo) < oo.
  A += 1
  
  V = (1 - alpha_n) * V + alpha_n * v
  # v0 v1 v3 ... t.q. vi dans [0,99].  alpha_n = 1/n
  # iter 1. V = v0
  # iter 2. V = 1/2 * v0  + 1/2 * v1 = (v0 + v1) / 2
  # iter 3. V =  (1 - 1/3) *  (v0 + v1) / 2 + 1/3 * v2
  #           =  2/3 * (v0 + v1) / 2 + 1/3 * v2
  #           =  (v0 + v1)/3   + v2/3 = (v0 + v1 + v2) /3
  # ...
  # iter n. 
  # 
  #     alpha_n = 1/(200+n) 
  s += v
  n += 1
  print ("difference =", abs(V - s/n))
  VM.append (s/n)
  QM.append (V)
  D.append (abs(V - s/n))

print('Alpha, True');
print(V, s/n)

plt.plot(QM, color = 'b')
plt.plot(VM, color = 'r')
plt.show()
