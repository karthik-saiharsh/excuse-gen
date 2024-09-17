'''
Author: ILLINDALA KARTHIK SAIHARSH
Version: 1.0.0
Date: 17/09/2024
license: MIT
Description: A simple app that keeps generating excuses, built using Python, Qt and the Excuser Api
'''
from PySide6.QtWidgets import QApplication
from PySide6.QtQml import QQmlApplicationEngine
from PySide6.QtCore import Slot, QObject
from PySide6.QtGui import QIcon
import sys
import requests
import threading
from pymsgbox import alert

class brain(QObject):
    def __init__(self):
        QObject.__init__(self)

    @Slot(str, result=str)
    def getExcuse(self, cat):
        func = threading.Thread(target=self.set_excuse, args=(cat,))
        func.start()
            
    def set_excuse(self, cat):
        match cat:
            case 'All':
                excuse = requests.get("https://excuser-three.vercel.app/v1/excuse").json()
                window.rootObjects()[0].setProperty("excuse", excuse[0]['excuse'])
            case _:
                excuse = requests.get(f"https://excuser-three.vercel.app/v1/excuse/{cat.strip().lower()}").json()
                window.rootObjects()[0].setProperty("excuse", excuse[0]['excuse'])

    @Slot()
    def display_about(self):
        message = "A Simple Desktop widget that can generate Excuses based on a selected category.\n\nCreated By: I.Karthik Saiharsh\nCredits: Excuser API(https://github.com/primeTanM/Excuser)"
        alert(message, "About the App")

    

    


app = QApplication(sys.argv)
app.setWindowIcon(QIcon("icon.png"))
backend = brain()    
    
window = QQmlApplicationEngine()
window.quit.connect(app.quit)
window.rootContext().setContextProperty("link", backend)
window.load("assets/ui.qml")
sys.exit(app.exec())
