from cvzone.HandTrackingModule import HandDetector
import cv2
import os
import numpy as np
import time


class PresentationController:
    def __init__(self):
        self.width, self.height = 900, 450
        self.gestureThreshold = 300
        self.folderPath = "camorim_getx_app/lib/Python-Code-ML/Computer-Vision/saida"
        self.detectorHand = HandDetector(detectionCon=0.8, maxHands=1)
        self.presentation = Presentation(self.folderPath, self.width, self.height)
        self.handGestureController = HandGestureController(
            self.detectorHand, self.gestureThreshold
        )

    def run(self):
        cap = cv2.VideoCapture(0)
        cap.set(3, self.width)
        cap.set(4, self.height)

        while True:
            # setup
            success, img = cap.read()
            img = cv2.flip(img, 1)
            self.presentation.updateCurrentImage()

            #
            hands, img = self.detectorHand.findHands(img, flipType=False)

            # Processa os gestos das mãos
            self.handGestureController.moverTelasApresentacao(hands, self.presentation)

            self.handGestureController.desenharLinhas(img=img, width=self.width)

            # Reduz a apresentação
            img_reduzida = cv2.resize(self.presentation.imgCurrent, dsize=(1100, 700))
            cv2.imshow("Slides like Steve Jobs", img_reduzida)
            cv2.imshow("Camera", img)

            # Controle de saída
            if cv2.waitKey(1) == ord("q"):
                break


class HandGestureController:
    def __init__(self, detectorHand, gestureThreshold):
        self.detectorHand = detectorHand
        self.gestureThreshold = gestureThreshold
        self.buttonPressed = False
        self.counter = 0
        self.delay = 30
        self.annotations = [[], [], []]
        self.annotationNumber = -1
        self.annotationStart = False

    def delay(self, s):
        time.sleep(s)

    def resetState(self):
        self.annotations = [[], [], []]
        self.annotationNumber = -1
        self.annotationStart = False

        return self.annotations, self.annotationNumber, self.annotationStart

    def moverTelasApresentacao(self, hands, presentation):
        try:
            if hands and not self.buttonPressed:
                hand = hands[0]
                handType = hand["type"]  # Pega o tipo de mão (esquerda ou direita)
                fingers = self.detectorHand.fingersUp(hand)
                print("Mão: ", handType, ", Dedos Levantados: ", fingers)
                cx, cy = hand["center"]
                xVal = np.interp(
                    hand["lmList"][8][0],
                    [presentation.width // 2, presentation.width],
                    [0, presentation.width],
                )
                yVal = np.interp(
                    hand["lmList"][8][1],
                    [150, presentation.height - 150],
                    [0, presentation.height],
                )

                indexFinger = (
                    int(xVal),
                    int(yVal),
                )  # Coordenadas convertidas para inteiros

                #! 1:15:30
                if cy <= self.gestureThreshold:
                    #! Gesture 1 - Movimento para Esquerda/Direita (NUM 1)
                    if fingers == [1, 1, 0, 0, 0]:
                        if handType == "Left":  # Mão esquerda: decrementa o contador
                            if presentation.imgNumber > 0:
                                presentation.imgNumber -= 1
                                print("\n\nMovendo para a imagem anterior")
                                self.resetState()

                        elif handType == "Right":  # Mão direita: incrementa o contador
                            if (
                                presentation.imgNumber
                                < len(presentation.pathImages) - 1
                            ):
                                presentation.imgNumber += 1
                                print("\n\nMovendo para a próxima imagem")
                                self.resetState()
                        self.buttonPressed = True

                    #! Gesture 2 - Finger Point
                    if fingers == [1, 1, 1, 0, 0]:
                        try:
                            cv2.circle(
                                presentation.imgCurrent,
                                indexFinger,
                                12,
                                (0, 0, 255),
                                cv2.FILLED,
                            )
                        except:
                            print("Saiu da tela")

                    #! Gesture 3 = Desenhar na tela(NUM 2)
                    if fingers == [1, 1, 1, 0]:
                        if self.annotationStart is False:
                            self.annotationStart = True
                            self.annotationNumber += 1
                            self.annotations.append([])
                        cv2.circle(
                            presentation.imgCurrent,
                            indexFinger,
                            12,
                            (0, 0, 255),
                            cv2.FILLED,
                        )
                        self.annotations[self.annotationNumber].append(indexFinger)

                    else:
                        self.annotationStart = False

                    #! Gesture 4 - Limpar a tela(NUM 3)
                    if fingers == [0, 1, 1, 1, 0]:
                        if self.annotations:
                            self.buttonPressed = True
                            self.annotations = [[]]
                            self.annotationNumber = -1
                        print("Limpando a tela")

            # Se ocorrer algum erro no reconhecimento de gestos
            else:
                print("Nenhuma mão detectada")
                self.annotationStart = False
        except ValueError as e:
            print("Erro: ", e)

        # Controle de delay para evitar múltiplas detecções
        if self.buttonPressed:
            self.counter += 1
            if self.counter > self.delay:
                self.counter = 0
                self.buttonPressed = False

        for i in range(len(self.annotations)):
            for j in range(len(self.annotations[1])):
                if j != 0:
                    cv2.line(
                        presentation.imgCurrent,
                        self.annotations[i][j - 1],
                        self.annotations[i][j],
                        (0, 0, 200),
                        12,
                    )

    def desenharLinhas(self, img, width):
        cv2.line(
            img,
            (0, self.gestureThreshold),
            (width, self.gestureThreshold),
            (0, 255, 0),
            10,
        )


class Presentation:
    def __init__(self, folderPath, width, height):
        self.folderPath = folderPath
        self.width = width
        self.height = height
        self.imgNumber = 0
        self.annotations = [[]]
        self.annotationNumber = -1
        self.pathImages = sorted(os.listdir(folderPath), key=len)
        self.imgCurrent = None
        self.updateCurrentImage()

    def updateCurrentImage(self):
        pathFullImage = os.path.join(self.folderPath, self.pathImages[self.imgNumber])
        print(pathFullImage)
        self.imgCurrent = cv2.imread(pathFullImage)


def main():
    # Cria uma instância do controlador da apresentação
    presentationController = PresentationController()

    # Executa o controlador da apresentação
    presentationController.run()


main()
