import{c as a}from"./index-DaN8B6MP.js";import{r as u}from"./main-0QxIHhpl.js";function d(o,e){const[s,c]=u.useState(!1),t=(e==null?void 0:e.successDuration)??2e3;return u.useEffect(()=>{if(s&&t){const r=setTimeout(()=>{c(!1)},t);return()=>{clearTimeout(r)}}},[s,t]),[s,()=>{const r=a(o);c(r)}]}export{d as u};
//# sourceMappingURL=use-clipboard-1Q9SBS-z.js.map
