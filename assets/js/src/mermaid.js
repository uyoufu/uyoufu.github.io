{% if site.mermaid.enable %}
	document.write('<script src="{{ site.mermaid.src }}"></script>');
	{% if site.mermaid.markdown_expand %}
	$(".language-mermaid").attr("class", "mermaid");
	{% endif %}
	$(window).on("load", function () {
	  mermaid.initialize({
		  startOnLoad:true,
		  });
	});
{% endif %}
