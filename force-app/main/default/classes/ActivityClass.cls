/*************************************************************************
Nombre de la Clase:     ActivityClass
Versión :               2.0
Fecha de Creación :     13/02/2023
Funcionalidad :         Poder modificar e interactuar con las actividades.
Clase de Prueba:        

Historial de Modificaciones:
-------------------------------------------------------------------------
* Desarrollador        - Fecha –        Descripción
* -----------------------------------------------------------------------
* Andres Tarra        13/02/2023       Versión 
* Daniela Sanchez     26/02/2023       Version 2.0 Se colocan los metodos
*                                      mas genericos para diferentes usos.
* 

*************************************************************************/
public class ActivityClass {
    public String identificacion;
    public string usuario;
    public String numeroOp;
    public String asunto;
    public String comentario;
    public String estado;
    public Date fechaVencimiento;
    
    public ActivityClass() {}
    
    /*Metodo: Crear tarea.*/
    public static List<TaskResponse> CrearTarea(MiddlewareActivity createTask) {
        List<Opportunity> op = new List<Opportunity> ();
        List<TaskResponse> value = new List<TaskResponse> ();
        List<Task> tareas = new List<Task> ();
        TaskResponse rt = new TaskResponse();
        List<Account> cliente = new List<Account>();
        Task tar = new Task();
        if (createTask.Actividad.identificacion != null || createTask.Actividad.identificacion != '') {
            cliente = [Select ID, PersonContactId from Account where Identificacion__c = :createTask.Actividad.identificacion];
            if (cliente == null || cliente.isEmpty()) {
                rt.mensaje = 'No tiene información del cliente.';
            	value.add(rt);
            } else {
                if ((createTask.Actividad.numeroOp != null || createTask.Actividad.numeroOp != '') && (createTask.Actividad.asunto != null || createTask.Actividad.asunto != '')) {
                    op = [Select ID from Opportunity where Numero_OP__c = :createTask.Actividad.numeroOp];
                    if (op == null || op.isEmpty()) {
                        rt.mensaje = 'No se encuentra op en Salesforce';
                        value.add(rt);
                    } else {
                        try{
                            tar.WhoId = cliente[0].PersonContactId;
                            tar.WhatId = op[0].ID;
                            tar.Subject = createTask.Actividad.asunto;
                            tar.Description = createTask.Actividad.comentario;
                            tar.Status = createTask.Actividad.estado;
                            tar.ActivityDate = createTask.Actividad.fechaVencimiento;
                            tar.OwnerId = createTask.Actividad.usuario;
                            insert tar;
                            
                            tareas = [Select Id, Subject, Status from Task where WhatId = :op[0].Id and Subject = :createTask.Actividad.asunto and Status = :createTask.Actividad.estado order by CreatedDate Desc];
                            if (!tareas.isEmpty()) {
                                rt.asuntoTarea = tareas[0].Subject;
                                rt.estadoTarea = tareas[0].Status;
                                rt.mensaje = 'Tarea creada con exito';
                                value.add(rt);
                            } else {
                                rt.mensaje = 'No se pudo crear la tarea';
                                value.add(rt);
                            }
                        } catch(Exception e) {
                            rt.mensaje = 'No se pudo crear la tarea' + e.getMessage();
                            value.add(rt);
                        }
                    }
                }
            }
        }
        return value;
    }
    
    /*Metodo: Actualizar tarea.*/
    public static List<TaskResponse> ActualizarTarea(String numOp, String estado, String usuario, String asunto) {
        TaskResponse rt = new TaskResponse();
        List<TaskResponse> value = new List<TaskResponse>();
        List<Task> tar = new List<Task>();
        List<Opportunity> op = [Select Id, Name, Numero_OP__c from Opportunity where Numero_OP__c = :numOp LIMIT 1];
        if(op == null || op.isEmpty()) {
            rt.mensaje = 'Op no encontrada';
            value.add(rt);
        } else {
            tar = [Select Id, Status, ActivityDate, OwnerId from Task where WhatId = :op[0].Id and Subject = :asunto and Status = 'Open' order by CreatedDate Desc];
            if (!tar.isEmpty()) {
                if (estado != null || estado != '') {
                    if (tar[0].Status != estado) {
                        tar[0].Status = estado;
                        if(usuario == 'BOT'){
                            tar[0].OwnerId = '0054O00000A10KNQAZ';
                        }else{
                            tar[0].OwnerId = usuario;
                        } 
                        update tar[0];
                        
                        Task tar_update = [Select Subject, Status, ActivityDate from Task where WhatId = :op[0].Id and Subject = :asunto order by CreatedDate Desc LIMIT 1];
                        rt.numOp = op[0].Numero_OP__c;
                        rt.asuntoTarea = tar_update.Subject;
                        rt.estadoTarea = tar_update.Status;
                        rt.mensaje = 'Tarea actualizada con exito';
                        value.add(rt);
                    } else {
                        rt.mensaje = 'No se pudo actualizar la tarea';
                        value.add(rt);
                    }
                } else {
                    rt.mensaje = 'Sin estado para actualizar';
                    value.add(rt);
                }
            } else {
                rt.mensaje = 'No se encontró tarea';
                value.add(rt);
            }
        }
        return value;
    }
    
    /*Metodo: Envio de informacion de tareas de cita de entrega asignada. */
    public static List<TareaCitaOp> ObtenerTareasOp(String numOp) {
        TareaCitaOp tar;
        List<TareaCitaOp> value = new List<TareaCitaOp> ();
        try {
            Opportunity op = [Select Id, Name, Numero_OP__c from Opportunity where Numero_OP__c = :numOp LIMIT 1];
            List<Task> tareasOp = [Select Subject, What.Name, Status, ActivityDate, CreatedDate from Task where WhatId = :op.Id and Status = 'Open' order by CreatedDate Desc];
            if(!tareasOp.isEmpty()){
                for (Integer i = 0; i < tareasOp.size(); i++) {
                    tar = new TareaCitaOp();
                    tar.subject = tareasOp[i].Subject;
                    tar.opNumber = op.Numero_OP__c;
                    tar.opName = tareasOp[i].What.Name;
                    tar.status = tareasOp[i].Status;
                    tar.dueDate = tareasOp[i].ActivityDate;
                    tar.createdDate = tareasOp[i].CreatedDate.date();
                    tar.message = 'Tarea encontrada';
                    
                    value.add(tar);
                }
            } else {
                tar.message = 'No se encontraron tareas asignadas a esta Op';
                value.add(tar);
            }
        } catch(Exception e) {
            tar.message = 'No se pudo obtener tarea' + e.getMessage();
            value.add(tar);
        }
        return value;
    }
}