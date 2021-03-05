# Convergence test for online mean algorithm
# very part of q-learning

from random import random, shuffle
import matplotlib.pyplot as plt

V = 0
n = 0
s = 0
A = 10

values = [int(100*random()) for i in range(10000)]

D = []
for v in values:
  power = 1
  alpha_n = 1/(A**power)
  # Try different values of power. Smaller than 1, and greater than > 1.
  # Algorithm converges when sum(alpha_n,1,oo) > oo and sum(alpha_n**2,1,oo) < oo.

  A += 1
  V = (1 - alpha_n) * V + alpha_n * v
  s += v
  n += 1
  print ("difference =", abs(V - s/n))
  D.append (abs(V - s/n))

print('Alpha, True');
print(V, s/n)

plt.plot(D)
plt.show()
