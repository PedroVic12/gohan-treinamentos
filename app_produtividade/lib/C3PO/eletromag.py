import numpy as np
import matplotlib.pyplot as plt
from mpl_toolkits.mplot3d import Axes3D

# 2. Criar o campo magnético:**

# Uma maneira simples de criar um campo magnético é definir sua magnitude e direção em cada ponto do espaço. Você pode criar um campo magnético rotacional usando a seguinte função:


def campo_magnetico(x, y, z):
    """
    Define um campo magnético rotacional.

    Parâmetros:
        x, y, z: coordenadas do ponto no espaço

    Retorna:
        Campo magnético (magnitude e direção) em (x, y, z)
    """

    r = np.sqrt(x**2 + y**2 + z**2)
    theta = np.arctan2(y, x)

    Bx = -np.sin(theta) / r**3
    By = np.cos(theta) / r**3
    Bz = 0

    return np.array([Bx, By, Bz])


# O gradiente de um campo vetorial é um tensor de segunda ordem que descreve como o campo varia no espaço. Você pode calcular o gradiente do campo magnético usando o operador `np.gradient`.


def gradiente(campo, dx=1, dy=1, dz=1):
    """
    Calcula o gradiente de um campo vetorial.

    Parâmetros:
        campo: Campo vetorial (matriz 3D com componentes x, y, z)
        dx, dy, dz: espaçamento entre os pontos no espaço

    Retorna:
        Gradiente do campo vetorial (tensor de segunda ordem)
    """

    grad_x, grad_y, grad_z = (
        np.gradient(campo[:, :, 0], dx, dy, dz),
        np.gradient(campo[:, :, 1], dx, dy, dz),
        np.gradient(campo[:, :, 2], dx, dy, dz),
    )
    return np.stack([grad_x, grad_y, grad_z], axis=-1)


######Você pode visualizar o campo magnético usando o pacote `matplotlib`. Para visualizar o campo rotacional, você pode usar uma coleção de setas que mostram a direção e a magnitude do campo em cada ponto.


def visualizar_campo_magnetico(campo, x, y, z):
    """
    Visualiza o campo magnético rotacional.

    Parâmetros:
        campo: Campo magnético (matriz 3D com componentes x, y, z)
        x, y, z: coordenadas do ponto no espaço
    """

    fig = plt.figure()
    ax = fig.add_subplot(111, projection="3d")

    ax.quiver(x, y, z, campo[:, :, 0], campo[:, :, 1], campo[:, :, 2])
    ax.set_xlabel("x")
    ax.set_ylabel("y")
    ax.set_zlabel("z")
    plt.show()


# Você pode visualizar o gradiente do campo magnético usando uma coleção de tensores que mostram a direção e a magnitude do gradiente em cada ponto.


def visualizar_gradiente(gradiente, x, y, z):
    """
    Visualiza o gradiente do campo magnético.

    Parâmetros:
        gradiente: Gradiente do campo magnético (tensor de segunda ordem)
        x, y, z: coordenadas do ponto no espaço
    """

    fig = plt.figure()
    ax = fig.add_subplot(111, projection="3d")

    for i in range(x.shape[0]):
        for j in range(y.shape[0]):
            for k in range(z.shape[0]):
                tensor = gradiente[i, j, k]
                eigenvalues, eigenvectors = np.linalg.eig(tensor)
                ax.plot(
                    [x[i], x[i] + 0.5 * eigenvectors[0, 0]],
                    [y[j], y[j] + 0.5 * eigenvectors[0, 1]],
                    [z[k], z[k] + 0.5 * eigenvectors[0, 2]],
                    color="r",
                )
                ax.plot(
                    [x[i], x[i] + 0.5 * eigenvectors[1, 0]],
                    [y[j], y[j] + 0.5 * eigenvectors[1, 1]],
                    [z[k], z[k] + 0.5 * eigenvectors[1, 2]],
                    color="g",
                )
                ax.plot(
                    [x[i], x[i] + 0.5 * eigenvectors[2, 0]],
                    [y[j], y[j] + 0.5 * eigenvectors[2, 1]],
                    [z[k], z[k] + 0.5 * eigenvectors[2, 2]],
                    color="b",
                )

    ax.set_xlabel("x")
    ax.set_ylabel("y")
    ax.set_zlabel("z")
    plt.show()


# Definir o espaço
x = np.linspace(-10, 10, 50)
y = np.linspace(-10, 10, 50)
z = np.linspace(-10, 10, 50)
X, Y, Z = np.meshgrid(x, y, z)

# Criar o campo magnético
campo = campo_magnetico(X, Y, Z)

# Calcular o gradiente
gradiente = gradiente(campo)

# Visualizar o campo magnético
visualizar_campo_magnetico(campo, X, Y, Z)

# Visualizar o gradiente
visualizar_gradiente(gradiente, X, Y, Z)
