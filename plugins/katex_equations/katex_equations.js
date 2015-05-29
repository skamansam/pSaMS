$( document ).ready(function() {
  $('.post .body').each(function() {
    var self = this
    renderMathInElement(
            self,
            {
                delimiters: [
                    {left: "$$!", right: "$$", display: true},
                    {left: "\\[", right: "\\]", display: true},
                    //{left: "$", right: "$", display: false},
                    {left: "$$", right: "$$", display: false},
                    {left: "\\(", right: "\\)", display: false}
                ]
            }
        );
  })
});
