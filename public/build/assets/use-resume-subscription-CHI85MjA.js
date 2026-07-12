import{y as r,ar as n,as as a,aL as e,z as o,m as u}from"./main-0QxIHhpl.js";function p(){const{trans:t}=r();return n({mutationFn:s=>i(s),onSuccess:()=>{e(t(o("Subscription renewed.")))},onError:s=>a(s)})}function i({subscriptionId:t}){return u.post(`billing/subscriptions/${t}/resume`).then(s=>s.data)}export{p as u};
//# sourceMappingURL=use-resume-subscription-CHI85MjA.js.map
