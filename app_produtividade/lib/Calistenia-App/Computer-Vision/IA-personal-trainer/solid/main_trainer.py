import cv2
import time
from PoseDetector import PoseDetector
from ia_trainer import ExerciseAnalyzer


def main():
    cap = cv2.VideoCapture(0)  # Altere para o caminho do seu vídeo se necessário
    pTime = 0
    detector = PoseDetector()
    analyzer = ExerciseAnalyzer(detector)

    while True:
        success, img = cap.read()
        img = detector.findPose(img)
        analyzer.analyzeExercise(img)

        cTime = time.time()
        fps = 1 / (cTime - pTime)
        pTime = cTime
        cv2.putText(
            img, str(int(fps)), (70, 50), cv2.FONT_HERSHEY_PLAIN, 3, (255, 0, 0), 3
        )

        cv2.imshow("Image", img)
        if cv2.waitKey(1) & 0xFF == ord("q"):
            break

    cap.release()
    cv2.destroyAllWindows()


if __name__ == "__main__":
    main()
