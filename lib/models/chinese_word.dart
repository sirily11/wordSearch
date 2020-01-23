class ChineseWord {
    String word;
    String oldword;
    String strokes;
    String pinyin;
    String radicals;
    String explanation;
    String more;

    ChineseWord({
        this.word,
        this.oldword,
        this.strokes,
        this.pinyin,
        this.radicals,
        this.explanation,
        this.more,
    });

    factory ChineseWord.fromJson(Map<String, dynamic> json) => ChineseWord(
        word: json["word"],
        oldword: json["oldword"],
        strokes: json["strokes"],
        pinyin: json["pinyin"],
        radicals: json["radicals"],
        explanation: json["explanation"],
        more: json["more"],
    );

    Map<String, dynamic> toJson() => {
        "word": word,
        "oldword": oldword,
        "strokes": strokes,
        "pinyin": pinyin,
        "radicals": radicals,
        "explanation": explanation,
        "more": more,
    };
}