import statistics
import matplotlib.pyplot as plt

def p06_c_01():
    num = [
        65, 70, 20, 50, 60, 25, 55, 40, 10, 73, 50,
        60, 20, 40, 35, 15, 25, 45, 60, 40, 30, 10,
        27, 55, 20, 78, 35, 90, 65, 40, 30, 35, 75,
        60, 70, 45, 30, 65, 80, 55, 25,
    ]

    mean = statistics.mean(num)
    stdev = statistics.pstdev(num)
    thresh = [mean+1.5*stdev, mean, mean-stdev, mean-1.5*stdev, 0]

    x = list(range(5))
    x_labels = ['A', 'B', 'C', 'D', 'F']
    y = [0]*5
    for v in num:
        for i, t in enumerate(thresh):
            if v >= t:
                y[i] += 1
                break
    y_labels = [str(v) for v in y]

    fig, axs = plt.subplots(2)
    axs[0].bar(x, y, label=y_labels, tick_label=x_labels)
    axs[1].pie(y, labels=x_labels)

    fig.savefig('hw01-ch02_p06-c-01.svg')

def p09_a_01():
    fig, ax = plt.subplots()

    x = [55, 92, 49, 97, 99, 58, 89, 96, 39, 80, 87, 74, 85, 97, 75, 68, 45, 63, 88]
    y = [65, 70, 20, 50, 60, 25, 58, 40, 10, 73, 50, 60, 20, 35, 20, 40, 15, 25, 42]
    x, y = zip(*sorted(zip(x, y)))
    ax.scatter(x, y)

    reg_x = []
    reg_y = []
    bin = 3
    for i in range(0, len(x), bin):
        _x = x[i:i+bin]
        _y = y[i:i+bin]
        reg_x.append(_x[0])
        reg_x.append(_x[-1])
        reg_y.append(statistics.mean(_y))
        reg_y.append(statistics.mean(_y))
    ax.step(reg_x, reg_y, where='mid')

    fig.savefig('hw01-ch02_p09-a-01.svg')

def p10_b_01():
    fig, ax = plt.subplots()

    x = [-2, -1, 0, 1, 2]
    y = [0, 2, 4, 2, 0]
    ax.scatter(x, y)
    fig.savefig('hw01-ch02_p10-b-01.svg')

if __name__ == '__main__':
    p06_c_01()
    p09_a_01()
    p10_b_01()
