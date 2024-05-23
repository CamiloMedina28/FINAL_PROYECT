function switchSheet(nuevocss) {
    let theme = document.getElementById("theme");
      theme.href = nuevocss;
      localStorage.setItem("estado", nuevocss);
}
window.onload=function()
{

    if(localStorage.getItem("estado")!=null)
    {
        estado =localStorage.getItem("estado");

        document.getElementById('theme').href = estado;

    }
}