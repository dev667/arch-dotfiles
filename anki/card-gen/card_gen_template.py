import pandas as pd

# Inhalt für die Anki-Karten basierend auf den Themen des PDFs
content = [
    {"Text (Front)": "Ein {{c1::endlicher Automat}} ist ein Modell zur Erkennung von Sprachen, das durch endlich viele Zustände arbeitet."},
    {"Text (Front)": "Ein deterministischer endlicher Automat (DFA) ist durch ein {{c1::5-Tupel}} definiert: (Z, Σ, δ, q0, E)."},
    {"Text (Front)": "Das Eingabealphabet eines DFA wird mit {{c1::Σ}} bezeichnet."},
    {"Text (Front)": "Die Überführungsfunktion in einem DFA wird mit {{c1::δ}} dargestellt und definiert die Zustandsübergänge."},
    {"Text (Front)": "Was beschreibt der Startzustand eines DFA? (Antwort: Er wird durch {{c1::q0}} bezeichnet und ist der Zustand, in dem der Automat beginnt.)"},
    {"Text (Front)": "Was ist eine reguläre Sprache? (Antwort: Eine Sprache, die von einem {{c1::DFA}} erkannt wird.)"},
    {"Text (Front)": "Die Klasse aller regulären Sprachen wird als {{c1::REG}} bezeichnet."},
    {"Text (Front)": "Was sind die Endzustände in einem DFA? (Antwort: Zustände in der Menge {{c1::E}}, bei denen der Automat akzeptiert.)"},
    {"Text (Front)": "Welche Bedingung muss ein Wort erfüllen, damit es von einem DFA akzeptiert wird? (Antwort: Es muss eine akzeptierende {{c1::Zustandsfolge}} geben, die zum Endzustand führt.)"},
    {"Text (Front)": "Was bedeutet es, dass eine Sprache regulär ist? (Antwort: Sie kann von einem endlichen Automaten wie einem {{c1::DFA}} erkannt werden.)"},
]


# Erstellen des DataFrames und Speichern als CSV-Datei
df = pd.DataFrame(content)
df.to_csv("Theoretische_Informatik_Karteikarten.csv", index=False)

print("Die Datei wurde erfolgreich erstellt.")

