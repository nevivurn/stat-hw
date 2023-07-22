import statistics
import matplotlib.pyplot as plt

def p05_a_01():
    fig, ax = plt.subplots()

    x = [
        16, 22, 29, 39, 49, 65, 82, 96, 118,
        133, 155, 174, 191, 221, 256, 302, 335, 400,
    ]
    y = [
        17, 18, 19, 22, 28, 38, 49, 53, 57,
        65, 79, 95, 111, 131, 161, 204, 266, 339,
    ]
    ax.scatter(x, y)

    fig.savefig('hw07-p05-a-01.svg')

if __name__ == '__main__':
    p05_a_01()
